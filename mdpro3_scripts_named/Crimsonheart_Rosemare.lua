--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-21T00:00:00
-- Card: Crimsonheart Rosemare  (ID: 211120)
-- Type: Trap / Continuous
-- Setcode: 0x95c (Crimsonheart)
-- (Trap Monster form: Illusion / Tuner / LIGHT / Level 6 / ATK 2300 / DEF 1800)
--
-- Effect Text:
-- You can only use each effect of "Crimsonheart Rosemare" once per turn.
-- (1) Special Summon this card as a Normal Monster (Illusion/Tuner/LIGHT/Level 6/ATK 2300/DEF 1800)
-- (this card is also still a Trap), then you can return 1 monster your opponent controls to the hand,
-- or, if you control "Barren Lady Lacrimosaica", you can shuffle it into the Deck instead.
-- (2) If this card is in your GY (Quick Effect): You can target 1 "Barren Lady Lacrimosaica" you
-- control; Set this card, and if you do, return that target to the hand.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Rosemare
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211000)
	--(1) activate: SS this card as a Normal Trap Monster, then optionally bounce/shuffle 1 opp monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--(2) (Quick Effect) from GY: target 1 "Barren Lady Lacrimosaica" you control; Set this card, return target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,4))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id+o)
	e2:SetTarget(s.settg)
	e2:SetOperation(s.setop)
	c:RegisterEffect(e2)
end
--(1)
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id,0,TYPES_NORMAL_TRAP_MONSTER+TYPE_TUNER,2300,1800,6,RACE_ILLUSION,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.lacfilter(c)
	return c:IsFaceup() and c:IsCode(211000)
end
function s.thfilter(c)
	return c:IsAbleToHand()
end
function s.thtdfilter(c)
	return c:IsAbleToHand() or c:IsAbleToDeck()
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,id,0,TYPES_NORMAL_TRAP_MONSTER+TYPE_TUNER,2300,1800,6,RACE_ILLUSION,ATTRIBUTE_LIGHT) then return end
	c:AddMonsterAttribute(TYPE_NORMAL+TYPE_TUNER+TYPE_TRAP)
	if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)==0 then return end
	local haslac=Duel.IsExistingMatchingCard(s.lacfilter,tp,LOCATION_MZONE,0,1,nil)
	local ff=haslac and s.thtdfilter or s.thfilter
	if Duel.IsExistingMatchingCard(ff,tp,0,LOCATION_MZONE,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
		local tc=Duel.SelectMatchingCard(tp,ff,tp,0,LOCATION_MZONE,1,1,nil):GetFirst()
		if not tc then return end
		local todeck=false
		if haslac and tc:IsAbleToDeck() then
			if tc:IsAbleToHand() then
				todeck=Duel.SelectOption(tp,aux.Stringid(id,2),aux.Stringid(id,3))==1
			else
				todeck=true
			end
		end
		if todeck then
			Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		end
	end
end
--(2)
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.lacfilter(chkc) end
	if chk==0 then return e:GetHandler():IsSSetable()
		and Duel.IsExistingTarget(s.lacfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,s.lacfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and Duel.SSet(tp,c)~=0 and tc:IsRelateToEffect(e) and tc:IsControler(tp) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 六花的一瓣  (ID: 71734607)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Plant
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 321
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。从卡组选「六花的一瓣」以外的1只「六花」怪兽加入手卡或送去墓地。这个效果的发动后，直到回合结束时自己不是植物族怪兽不能特殊召唤。
-- ②：这张卡在墓地存在，自己场上没有怪兽存在的场合或者自己场上的怪兽只有植物族怪兽的场合，对方结束阶段才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--六花のひとひら
function c71734607.initial_effect(c)
	--to hand or grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71734607,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,71734607)
	e1:SetTarget(c71734607.target)
	e1:SetOperation(c71734607.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(71734607,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,71734608)
	e2:SetCondition(c71734607.spcon)
	e2:SetTarget(c71734607.sptg)
	e2:SetOperation(c71734607.spop)
	c:RegisterEffect(e2)
end
function c71734607.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x141) and not c:IsCode(71734607) and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c71734607.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c71734607.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c71734607.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,c71734607.cfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		if tc and tc:IsAbleToHand() and (not tc:IsAbleToGrave() or Duel.SelectOption(tp,1190,1191)==0) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.SendtoGrave(tc,REASON_EFFECT)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c71734607.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c71734607.splimit(e,c)
	return not c:IsRace(RACE_PLANT)
end
function c71734607.spfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c71734607.spcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=1-tp then return false end
	local ct1=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	local ct2=Duel.GetMatchingGroupCount(c71734607.spfilter,tp,LOCATION_MZONE,0,nil)
	local chk1=ct1==0
	local chk2=ct2>0 and ct1-ct2==0
	return chk1 or chk2
end
function c71734607.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c71734607.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end

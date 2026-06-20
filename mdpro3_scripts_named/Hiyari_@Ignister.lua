--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 冰冰妖@火灵天星  (ID: 41306080)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Cyberse
-- Level 1
-- ATK 300 | DEF 400
-- Setcode: 309
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上有「@火灵天星」怪兽存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：把这张卡以外的自己场上1只电子界族怪兽解放才能发动。从卡组把1只5星以上的「@火灵天星」怪兽加入手卡，这张卡的等级直到回合结束时变成4星。为这个效果发动而把连接怪兽解放的场合，可以再从卡组把1张「
-- “艾”之仪式」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ヒヤリ＠イグニスター
function c41306080.initial_effect(c)
	aux.AddCodeList(c,85327820)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41306080,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,41306080)
	e1:SetCondition(c41306080.spcon)
	e1:SetTarget(c41306080.sptg)
	e1:SetOperation(c41306080.spop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41306080,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,41306081)
	e2:SetCost(c41306080.thcost)
	e2:SetTarget(c41306080.thtg)
	e2:SetOperation(c41306080.thop)
	c:RegisterEffect(e2)
end
function c41306080.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x135)
end
function c41306080.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c41306080.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c41306080.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c41306080.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c41306080.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,c,RACE_CYBERSE) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,c,RACE_CYBERSE)
	e:SetLabel(g:GetFirst():GetType())
	Duel.Release(g,REASON_COST)
end
function c41306080.thfilter1(c)
	return c:IsLevelAbove(5) and c:IsSetCard(0x135) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c41306080.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c41306080.thfilter1,tp,LOCATION_DECK,0,1,nil)
		and not c:IsLevel(4) and c:IsLevelAbove(1) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c41306080.thfilter2(c)
	return c:IsCode(85327820) and c:IsAbleToHand()
end
function c41306080.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,c41306080.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	if g1:GetCount()>0 and Duel.SendtoHand(g1,nil,REASON_EFFECT)~=0 and g1:GetFirst():IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,g1)
		local c=e:GetHandler()
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(4)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
			local g2=Duel.GetMatchingGroup(c41306080.thfilter2,tp,LOCATION_DECK,0,nil)
			if bit.band(e:GetLabel(),TYPE_LINK)~=0 and g2:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(41306080,2)) then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local sg=g2:Select(tp,1,1,nil)
				Duel.SendtoHand(sg,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,sg)
			end
		end
	end
end

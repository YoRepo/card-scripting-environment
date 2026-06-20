--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 海皇的龙骑队  (ID: 74311226)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 4
-- ATK 1800 | DEF 0
-- Setcode: 119
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，自己的3星以下的海龙族怪兽可以直接攻击。
-- ②：这张卡为让水属性怪兽的效果发动而被送去墓地的场合发动。从卡组把「海皇的龙骑队」以外的1只海龙族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--海皇の竜騎隊
function c74311226.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c74311226.datg)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74311226,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c74311226.thcon)
	e2:SetTarget(c74311226.thtg)
	e2:SetOperation(c74311226.thop)
	c:RegisterEffect(e2)
end
function c74311226.datg(e,c)
	return c:IsLevelBelow(3) and c:IsRace(RACE_SEASERPENT)
end
function c74311226.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_COST) and re:IsActivated() and re:IsActiveType(TYPE_MONSTER)
		and re:GetHandler():IsAttribute(ATTRIBUTE_WATER)
end
function c74311226.thfilter(c)
	return not c:IsCode(74311226) and c:IsRace(RACE_SEASERPENT) and c:IsAbleToHand()
end
function c74311226.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c74311226.thop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c74311226.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

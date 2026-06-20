--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 恶魂邪苦止  (ID: 10456559)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上存在的这张卡被战斗破坏送去墓地时，可以从自己卡组把「恶魂邪苦止」加入手卡。之后卡组洗切。
--[[ __CARD_HEADER_END__ ]]

--悪魂邪苦止
function c10456559.initial_effect(c)
	--add
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetDescription(aux.Stringid(10456559,0))
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c10456559.condition)
	e1:SetTarget(c10456559.target)
	e1:SetOperation(c10456559.operation)
	c:RegisterEffect(e1)
end
function c10456559.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and c:IsPreviousControler(tp) and c:IsReason(REASON_BATTLE)
end
function c10456559.filter(c)
	return c:IsCode(10456559) and c:IsAbleToHand()
end
function c10456559.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10456559.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c10456559.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c10456559.filter,tp,LOCATION_DECK,0,1,3,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end

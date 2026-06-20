--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 强化人类 赛克  (ID: 80102359)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Psychic
-- Level 4
-- ATK 1500 | DEF 800
--
-- Effect Text:
-- 把自己墓地存在的1只念动力族怪兽从游戏中除外发动。这张卡的攻击力上升500。这个效果1回合可以使用最多2次。
--[[ __CARD_HEADER_END__ ]]

--強化人類サイコ
function c80102359.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80102359,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(2)
	e1:SetCost(c80102359.cost)
	e1:SetOperation(c80102359.operation)
	c:RegisterEffect(e1)
end
function c80102359.cfilter(c)
	return c:IsRace(RACE_PSYCHO) and c:IsAbleToRemoveAsCost()
end
function c80102359.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80102359.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c80102359.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c80102359.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 食魂者 巴祖  (ID: 40133511)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1600 | DEF 900
--
-- Effect Text:
-- 可以从自己的墓地选最多3张怪兽从游戏中除外。每除外1张卡，在对方回合结束前，这张卡的攻击力上升300。这个效果在自己的回合只能用1次。
--[[ __CARD_HEADER_END__ ]]

--魂を喰らう者 バズー
function c40133511.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40133511,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c40133511.cost)
	e1:SetOperation(c40133511.operation)
	c:RegisterEffect(e1)
end
function c40133511.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c40133511.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c40133511.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local cg=Duel.SelectMatchingCard(tp,c40133511.cfilter,tp,LOCATION_GRAVE,0,1,3,nil)
	Duel.Remove(cg,POS_FACEUP,REASON_COST)
	e:SetLabel(cg:GetCount())
end
function c40133511.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local count=e:GetLabel()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(count*300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END,2)
		c:RegisterEffect(e1)
	end
end

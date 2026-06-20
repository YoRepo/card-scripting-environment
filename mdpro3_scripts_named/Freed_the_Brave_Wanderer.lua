--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 流浪勇者 弗里德  (ID: 16556849)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1700 | DEF 1200
--
-- Effect Text:
-- 可以把自己墓地存在的2只光属性怪兽从游戏中除外，选择持有比场上表侧表示存在的这张卡的攻击力高的攻击力的场上表侧表示存在的1只怪兽破坏。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--放浪の勇者 フリード
function c16556849.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16556849,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c16556849.cost)
	e1:SetTarget(c16556849.tg)
	e1:SetOperation(c16556849.op)
	c:RegisterEffect(e1)
end
function c16556849.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c16556849.costfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c16556849.costfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c16556849.costfilter(co)
	return co:IsAttribute(ATTRIBUTE_LIGHT) and co:IsAbleToRemoveAsCost()
end
function c16556849.filter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c16556849.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c16556849.filter(chkc,e:GetHandler():GetAttack()) end
	if chk==0 then return Duel.IsExistingTarget(c16556849.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e:GetHandler():GetAttack()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c16556849.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e:GetHandler():GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c16556849.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsFaceup() and tc:IsRelateToEffect(e)
		and tc:GetAttack()>c:GetAttack() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 雷-神  (ID: 37829468)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 4
-- ATK ? | DEF 1000
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，自己场上表侧表示存在的光属性怪兽的攻击力上升自己墓地存在的光属性怪兽数量×100的数值。自己的结束阶段时，把自己场上表侧表示存在的1只光属性怪兽破坏。「雷-神」在场上只能
-- 有1只表侧表示存在。
--[[ __CARD_HEADER_END__ ]]

--RAI－JIN
function c37829468.initial_effect(c)
	c:SetUniqueOnField(1,1,37829468)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c37829468.atktg)
	e1:SetValue(c37829468.atkval)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37829468,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c37829468.descon)
	e2:SetTarget(c37829468.destg)
	e2:SetOperation(c37829468.desop)
	c:RegisterEffect(e2)
end
function c37829468.atktg(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c37829468.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsAttribute,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil,ATTRIBUTE_LIGHT)*100
end
function c37829468.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c37829468.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c37829468.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c37829468.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c37829468.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c37829468.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

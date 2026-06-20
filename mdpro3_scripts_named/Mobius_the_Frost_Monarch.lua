--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 冰帝 美比乌斯  (ID: 4929256)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 6
-- ATK 2400 | DEF 1000
--
-- Effect Text:
-- ①：这张卡上级召唤成功时，以场上最多2张魔法·陷阱卡为对象才能发动。那些卡破坏。
--[[ __CARD_HEADER_END__ ]]

--氷帝メビウス
function c4929256.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4929256,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c4929256.condition)
	e1:SetTarget(c4929256.target)
	e1:SetOperation(c4929256.operation)
	c:RegisterEffect(e1)
end
function c4929256.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c4929256.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c4929256.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c4929256.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c4929256.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c4929256.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c4929256.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(sg,REASON_EFFECT)
end

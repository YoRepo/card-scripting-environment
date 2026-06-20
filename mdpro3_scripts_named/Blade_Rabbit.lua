--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 剑齿兔  (ID: 58268433)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 2
-- ATK 400 | DEF 300
--
-- Effect Text:
-- 这张卡的表示形式从攻击表示变成表侧守备表示时，破坏对方场上1只怪兽。
--[[ __CARD_HEADER_END__ ]]

--ブレードラビット
function c58268433.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58268433,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c58268433.condition)
	e1:SetTarget(c58268433.target)
	e1:SetOperation(c58268433.operation)
	c:RegisterEffect(e1)
end
function c58268433.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_ATTACK) and c:IsFaceup() and c:IsDefensePos()
end
function c58268433.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c58268433.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

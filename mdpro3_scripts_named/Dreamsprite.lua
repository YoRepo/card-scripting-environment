--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 幻影妖精  (ID: 8687195)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Plant
-- Level 2
-- ATK 300 | DEF 200
--
-- Effect Text:
-- 这张卡受到从对方怪兽来的攻击的场合，让其他的自己场上1只怪兽承受攻击，进行伤害计算。
--[[ __CARD_HEADER_END__ ]]

--幻影の妖精
function c8687195.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8687195,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetCondition(c8687195.condition)
	e1:SetTarget(c8687195.target)
	e1:SetOperation(c8687195.operation)
	c:RegisterEffect(e1)
end
function c8687195.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler() and Duel.GetAttacker():IsControler(1-tp)
end
function c8687195.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc~=e:GetHandler() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c8687195.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local a=Duel.GetAttacker()
	if tc and tc:IsRelateToEffect(e) and a:IsAttackable() and not a:IsImmuneToEffect(e) then
		Duel.CalculateDamage(a,tc)
	end
end

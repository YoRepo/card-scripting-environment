--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 三千根针  (ID: 7852878)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 8
-- ATK 3000 | DEF 1800
--
-- Effect Text:
-- 守备表示的这张卡受到攻击的场合，若这张卡的守备力超过对方攻击怪兽的攻击力，伤害步骤结束时那只攻击怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--針三千本
function c7852878.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7852878,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c7852878.condition)
	e1:SetTarget(c7852878.target)
	e1:SetOperation(c7852878.operation)
	c:RegisterEffect(e1)
end
function c7852878.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler() and e:GetHandler():IsDefensePos()
		and Duel.GetAttacker():GetAttack()<e:GetHandler():GetDefense()
end
function c7852878.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetAttacker(),1,0,0)
end
function c7852878.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if not a:IsRelateToBattle() then return end
	Duel.Destroy(a,REASON_EFFECT)
end

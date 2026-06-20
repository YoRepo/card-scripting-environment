--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 等离子球  (ID: 92595545)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 3
-- ATK 900 | DEF 900
--
-- Effect Text:
-- 这张卡可以直接攻击对方玩家。这张卡直接攻击给与对方基本分战斗伤害时，这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--プラズマ・ボール
function c92595545.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92595545,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c92595545.condition)
	e2:SetTarget(c92595545.target)
	e2:SetOperation(c92595545.operation)
	c:RegisterEffect(e2)
end
function c92595545.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function c92595545.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c92595545.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end

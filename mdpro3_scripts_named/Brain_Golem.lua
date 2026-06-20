--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 巨脑怪  (ID: 17313545)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2500 | DEF 1800
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，场上表侧表示存在的光属性怪兽的效果无效化。这张卡战斗破坏光属性怪兽的场合，只有1次可以继续攻击。
--[[ __CARD_HEADER_END__ ]]

--ゴーレム
function c17313545.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c17313545.distg)
	c:RegisterEffect(e1)
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17313545,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(c17313545.atcon)
	e2:SetOperation(c17313545.atop)
	c:RegisterEffect(e2)
end
function c17313545.distg(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_EFFECT)
end
function c17313545.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return aux.bdcon(e,tp,eg,ep,ev,re,r,rp) and c:IsChainAttackable()
		and c:GetBattleTarget():IsAttribute(ATTRIBUTE_LIGHT)
end
function c17313545.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end

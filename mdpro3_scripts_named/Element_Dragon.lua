--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 元素龙  (ID: 30314994)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 4
-- ATK 1500 | DEF 1200
--
-- Effect Text:
-- ①：场上的怪兽属性让这张卡得到以下效果。
-- ●炎属性：这张卡的攻击力上升500。
-- ●风属性：这张卡战斗破坏对方怪兽时才能发动。这张卡只再1次可以继续攻击。
--[[ __CARD_HEADER_END__ ]]

--エレメント・ドラゴン
function c30314994.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetCondition(c30314994.atkcon)
	c:RegisterEffect(e1)
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(30314994,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(c30314994.atcon)
	e2:SetOperation(c30314994.atop)
	c:RegisterEffect(e2)
end
function c30314994.filter(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end
function c30314994.atkcon(e)
	return Duel.IsExistingMatchingCard(c30314994.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_FIRE)
end
function c30314994.atcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.bdocon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():IsChainAttackable()
		and Duel.IsExistingMatchingCard(c30314994.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_WIND)
end
function c30314994.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end

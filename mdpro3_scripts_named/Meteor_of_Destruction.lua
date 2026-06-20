--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 死亡流星  (ID: 33767325)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 给与对方基本分1000分伤害。对方基本分是3000以下的场合这张卡不能发动。
--[[ __CARD_HEADER_END__ ]]

--デス・メテオ
function c33767325.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c33767325.condition)
	e1:SetTarget(c33767325.damtg)
	e1:SetOperation(c33767325.damop)
	c:RegisterEffect(e1)
end
function c33767325.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(1-tp)>3000
end
function c33767325.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c33767325.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 异虫贵族  (ID: 7700132)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Reptile
-- Level 6
-- ATK 1500 | DEF 2400
-- Setcode: 62
--
-- Effect Text:
-- 反转：被对方怪兽的攻击反转的场合，给与对方基本分向这张卡攻击的对方怪兽的攻击力一半数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ワーム・ノーブル
function c7700132.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FLIP+EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(c7700132.damtg)
	e1:SetOperation(c7700132.damop)
	c:RegisterEffect(e1)
end
function c7700132.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetCurrentPhase()==PHASE_DAMAGE and e:GetHandler()==Duel.GetAttackTarget() then
		Duel.SetTargetPlayer(1-tp)
		Duel.SetTargetParam(math.floor(Duel.GetAttacker():GetAttack()/2))
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,math.floor(Duel.GetAttacker():GetAttack()/2))
	end
end
function c7700132.damop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetCurrentPhase()==PHASE_DAMAGE and e:GetHandler()==Duel.GetAttackTarget() then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Damage(p,d,REASON_EFFECT)
	end
end

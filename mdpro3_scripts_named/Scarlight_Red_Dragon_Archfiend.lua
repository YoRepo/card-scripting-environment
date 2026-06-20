--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 红莲魔龙·右红痕  (ID: 80666118)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 2500
-- Setcode: 4165
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- ①：这张卡的卡名只要在场上·墓地存在当作「红莲魔龙」使用。
-- ②：1回合1次，自己主要阶段才能发动。这张卡以外的持有这张卡的攻击力以下的攻击力的特殊召唤的效果怪兽全部破坏。那之后，给与对方这个效果破坏的怪兽数量×500伤害。
--[[ __CARD_HEADER_END__ ]]

--レッド・デーモンズ・ドラゴン・スカーライト
function c80666118.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--change name
	aux.EnableChangeCode(c,70902743,LOCATION_MZONE+LOCATION_GRAVE)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c80666118.destg)
	e2:SetOperation(c80666118.desop)
	c:RegisterEffect(e2)
end
function c80666118.filter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk) and c:IsSummonType(SUMMON_TYPE_SPECIAL)
		and c:IsType(TYPE_EFFECT)
end
function c80666118.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c80666118.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetAttack()) end
	local g=Duel.GetMatchingGroup(c80666118.filter,tp,LOCATION_MZONE,LOCATION_MZONE,c,c:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
end
function c80666118.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c80666118.filter,tp,LOCATION_MZONE,LOCATION_MZONE,aux.ExceptThisCard(e),c:GetAttack())
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,ct*500,REASON_EFFECT)
	end
end

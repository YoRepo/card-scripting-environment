--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 牲祭怀抱的爆弹  (ID: 89041555)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：上级召唤的对方怪兽的攻击宣言时才能发动。对方场上的表侧攻击表示怪兽全部破坏，给与对方1000伤害。
--[[ __CARD_HEADER_END__ ]]

--生贄の抱く爆弾
function c89041555.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c89041555.condition)
	e1:SetTarget(c89041555.target)
	e1:SetOperation(c89041555.activate)
	c:RegisterEffect(e1)
end
function c89041555.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and eg:GetFirst():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c89041555.filter(c)
	return c:IsAttackPos()
end
function c89041555.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c89041555.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c89041555.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c89041555.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c89041555.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 and Duel.Destroy(g,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end

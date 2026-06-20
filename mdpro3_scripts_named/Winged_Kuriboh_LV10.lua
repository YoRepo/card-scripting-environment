--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 羽翼栗子球 LV10  (ID: 98585345)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Fairy
-- Level 10
-- ATK 300 | DEF 200
-- Setcode: 4264100
--
-- Effect Text:
-- 这张卡不能通常召唤。这张卡只能通过「进化之翼」的效果特殊召唤。可以把自己场上表侧表示存在的这张卡作祭品，对方场上攻击表示的怪兽全部破坏，给与对方基本分破坏怪兽的原本的攻击力合计的数值的伤害。这个效果在
-- 对方战斗阶段中才能发动。
--[[ __CARD_HEADER_END__ ]]

--ハネクリボー LV10
function c98585345.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98585345,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_BATTLE_PHASE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c98585345.descon)
	e2:SetCost(c98585345.descost)
	e2:SetTarget(c98585345.destg)
	e2:SetOperation(c98585345.desop)
	c:RegisterEffect(e2)
end
c98585345.lvdn={33776734,48486809}
function c98585345.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
end
function c98585345.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c98585345.dfilter(c)
	return c:IsAttackPos()
end
function c98585345.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98585345.dfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c98585345.dfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c98585345.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c98585345.dfilter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local dg=Duel.GetOperatedGroup()
	local tc=dg:GetFirst()
	local dam=0
	while tc do
		local atk=tc:GetTextAttack()
		if atk<0 then atk=0 end
		dam=dam+atk
		tc=dg:GetNext()
	end
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end

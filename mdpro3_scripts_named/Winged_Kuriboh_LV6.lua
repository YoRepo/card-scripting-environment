--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 羽翼栗子球 LV6  (ID: 48486809)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Fairy
-- Level 6
-- ATK 300 | DEF 200
-- Setcode: 113768701513240740
--
-- Effect Text:
-- 这个卡名在规则上也当作「元素英雄」卡、「至爱」卡使用。这张卡不能通常召唤。「羽翼栗子球
-- LV6」1回合1次在把自己的手卡·场上（表侧表示）·墓地1只「元素英雄」融合怪兽或「羽翼栗子球」除外的场合才能从手卡·墓地特殊召唤。
-- ①：对方怪兽的攻击宣言时或者对方把场上的怪兽的效果发动时，把这张卡解放才能发动。那1只怪兽破坏，给与对方那个原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ハネクリボー LV6
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(s.spcon)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(s.descon)
	e3:SetCost(s.descost)
	e3:SetTarget(s.destg)
	e3:SetOperation(s.desop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(s.descon2)
	e4:SetTarget(s.destg2)
	e4:SetOperation(s.desop2)
	c:RegisterEffect(e4)
end
s.lvup={id}
function s.spfilter(c,tp)
	return (c:IsCode(57116033) or c:IsSetCard(0x3008) and c:IsType(TYPE_FUSION))
		and c:IsFaceupEx() and c:IsAbleToRemoveAsCost() and Duel.GetMZoneCount(tp,c)>0
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD+LOCATION_HAND,0,1,c,tp)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_GRAVE+LOCATION_ONFIELD+LOCATION_HAND,0,1,1,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function s.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetAttacker()
	if chk==0 then return tc:IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	if tc:GetTextAttack()>0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetTextAttack())
	end
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() and Duel.Destroy(tc,REASON_EFFECT)>0 and tc:GetTextAttack()>0 then
		Duel.Damage(1-tp,tc:GetTextAttack(),REASON_EFFECT)
	end
end
function s.descon2(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and re:GetHandler():IsOnField() and re:GetHandler():IsRelateToEffect(re) and re:IsActiveType(TYPE_MONSTER)
end
function s.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=re:GetHandler()
	if chk==0 then return tc:IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	if math.max(0,tc:GetTextAttack())>0 then Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0) end
end
function s.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=re:GetHandler()
	if tc:IsRelateToEffect(re) and tc:IsLocation(LOCATION_MZONE)
		and Duel.Destroy(tc,REASON_EFFECT)>0 and tc:GetTextAttack()>0 then
		Duel.Damage(1-tp,tc:GetTextAttack(),REASON_EFFECT)
	end
end

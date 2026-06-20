--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 变形斗士·磁铁I  (ID: 45593005)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Thunder
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 38
--
-- Effect Text:
-- 这张卡得到这张卡的表示形式的以下效果。
-- ●攻击表示：自己场上有这张卡以外的怪兽表侧攻击表示2只存在的场合，1回合1次，可以让这张卡的攻击力直到这个回合的结束阶段时上升那些怪兽的攻击力的合计数值。这个效果发动的回合，其他怪兽不能攻击。
-- ●守备表示：只要这张卡在场上表侧表示存在，自己场上存在的怪兽不能攻击。
--[[ __CARD_HEADER_END__ ]]

--D・マグネンI
function c45593005.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45593005,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c45593005.cona)
	e1:SetTarget(c45593005.tga)
	e1:SetOperation(c45593005.opa)
	c:RegisterEffect(e1)
	--def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c45593005.cond)
	c:RegisterEffect(e2)
end
function c45593005.cfilter(c)
	return c:IsFaceup() and c:IsAttackPos()
end
function c45593005.cona(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsDisabled() and e:GetHandler():IsAttackPos()
		and Duel.GetMatchingGroupCount(c45593005.cfilter,tp,LOCATION_MZONE,0,e:GetHandler())==2
		and not Duel.IsExistingMatchingCard(Card.IsDefensePos,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c45593005.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,c)
	Duel.SetTargetCard(g)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c45593005.ftarget)
	e1:SetLabel(c:GetFieldID())
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c45593005.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c45593005.filter(c,e)
	return c:IsFaceup() and c:IsRelateToEffect(e)
end
function c45593005.opa(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(c45593005.filter,nil,e)
	if sg:GetCount()==0 then return end
	local atk=sg:GetSum(Card.GetAttack)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
function c45593005.cond(e)
	return e:GetHandler():IsDefensePos()
end

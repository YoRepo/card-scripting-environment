--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 树冠之甲帝 比亚格拉姆  (ID: 27134209)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: EARTH
-- Race: Insect
-- Level 9
-- ATK 3400 | DEF 2800
--
-- Effect Text:
-- 这张卡不能通常召唤。把自己的手卡·墓地3只昆虫族·植物族怪兽除外的场合才能从手卡·墓地特殊召唤。自己对「树冠之甲帝 比亚格拉姆」1回合只能有1次特殊召唤。
-- ①：只要这张卡在怪兽区域存在，对方不能对应自己的魔法·陷阱卡的效果的发动把怪兽的效果发动。
-- ②：1回合1次，自己主要阶段才能发动。昆虫族·植物族怪兽以外的场上的表侧表示怪兽全部破坏。这个回合，这张卡不能直接攻击。
--[[ __CARD_HEADER_END__ ]]

--樹冠の甲帝ベアグラム
function c27134209.initial_effect(c)
	c:SetSPSummonOnce(27134209)
	c:EnableReviveLimit()
	--splimit
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e0)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCondition(c27134209.sprcon)
	e1:SetTarget(c27134209.sprtg)
	e1:SetOperation(c27134209.sprop)
	c:RegisterEffect(e1)
	--act limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c27134209.chainop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c27134209.destg)
	e3:SetOperation(c27134209.desop)
	c:RegisterEffect(e3)
end
function c27134209.sprfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_INSECT+RACE_PLANT) and c:IsAbleToRemoveAsCost()
end
function c27134209.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c27134209.sprfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,3,c)
end
function c27134209.sprtg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c27134209.sprfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=g:CancelableSelect(tp,3,3,nil)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c27134209.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c27134209.chainop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and ep==tp then
		Duel.SetChainLimit(c27134209.chainlm)
	end
end
function c27134209.chainlm(re,rp,tp)
	return tp==rp or not re:IsActiveType(TYPE_MONSTER)
end
function c27134209.desfilter(c)
	return c:IsFaceup() and not c:IsRace(RACE_INSECT+RACE_PLANT)
end
function c27134209.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c27134209.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c27134209.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c27134209.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c27134209.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 异响鸣之神奏-星光天魔  (ID: 1340142)
-- Type: Monster / Effect / Link
-- Attribute: WATER
-- Race: Spellcaster
-- ATK 3000 | LINK
-- Setcode: 419
--
-- Effect Text:
-- 包含「异响鸣」连接怪兽的怪兽2只
-- ①：只要自己场上有响鸣指示物6个以上存在，场上的这张卡不受「异响鸣」卡以外的卡的效果影响。
-- ②：这张卡在同1次的战斗阶段中在通常攻击外加上可以作出最多有自己场上的4星「异响鸣」怪兽数量的攻击。
-- ③：1回合1次，对方把怪兽特殊召唤之际才能发动。那次特殊召唤无效，那些怪兽破坏。那之后，自己场上3个响鸣指示物取除。
--[[ __CARD_HEADER_END__ ]]

--ヴァルモニカの神奏－ヴァーラル
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddLinkProcedure(c,nil,2,2,s.lcheck)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.imcon)
	e1:SetValue(s.efilter)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(s.atkval)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_SPSUMMON)
	e3:SetCountLimit(1)
	e3:SetCondition(s.discon)
	e3:SetTarget(s.distg)
	e3:SetOperation(s.disop)
	c:RegisterEffect(e3)
end
function s.lfilter(c)
	return c:IsLinkType(TYPE_LINK) and c:IsLinkSetCard(0x1a3)
end
function s.lcheck(g)
	return g:IsExists(s.lfilter,1,nil)
end
function s.cfilter(c)
	return c:GetCounter(0x6a)>0
end
function s.iee(c)
	return c:GetCounter(0x6a)
end
function s.imcon(e)
	local sg=Duel.GetMatchingGroup(s.cfilter,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,nil)
	local ct=sg:GetSum(s.iee)
	return ct>5
end
function s.efilter(e,te)
	return not te:GetOwner():IsSetCard(0x1a3)
end
function s.atkfilter(c)
	return c:IsLevel(4) and c:IsFaceup() and c:IsSetCard(0x1a3)
end
function s.atkval(e,c)
	return Duel.GetMatchingGroupCount(s.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and Duel.GetCurrentChain()==0
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x6a,3,REASON_EFFECT) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.NegateSummon(eg)
	if Duel.IsCanRemoveCounter(tp,1,0,0x6a,3,REASON_EFFECT) then
		Duel.BreakEffect()
		Duel.RemoveCounter(tp,1,0,0x6a,3,REASON_EFFECT)
	end
end

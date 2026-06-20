--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 暗之守护神  (ID: 26746975)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Warrior
-- Level 12
-- ATK 3800 | DEF 3800
-- Setcode: 4178
--
-- Effect Text:
-- 这个卡名在规则上也当作「门之守护神」卡使用。这张卡不能通常召唤，用「暗元素」的效果以及以下方法才能特殊召唤。
-- ●可以让自己的手卡·场上（表侧表示）·墓地·除外状态的「雷魔神-桑迦」「风魔神-修迦」「水魔神-斯迦」各1张回到卡组，从手卡·墓地特殊召唤。
-- ①：这张卡不会被战斗破坏。
-- ②：「暗元素」的效果特殊召唤的这张卡不受其他怪兽以及对方发动的魔法卡的效果影响。
--[[ __CARD_HEADER_END__ ]]

--闇の守護神－ダーク・ガーディアン
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,25955164,62340868,98434877,53194323)
	c:EnableReviveLimit()
	--Cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
	--battle indestructable
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e12:SetValue(1)
	c:RegisterEffect(e12)
	--summon success
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e13:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e13:SetCode(EVENT_SPSUMMON_SUCCESS)
	e13:SetCondition(s.regcon)
	e13:SetOperation(s.regop)
	c:RegisterEffect(e13)
end
function s.mfilter(c)
	return c:IsFaceupEx() and c:IsAbleToDeckAsCost() and c:IsCode(25955164,62340868,98434877)
end
function s.fselect(g,c,tp)
	return Duel.GetMZoneCount(tp,g)>0 and g:GetClassCount(Card.GetCode)==3
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(s.mfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,0,nil)
	return g:CheckSubGroup(s.fselect,3,3,c,tp)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(s.mfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:SelectSubGroup(tp,s.fselect,true,3,3,c,tp)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoDeck(g,tp,SEQ_DECKSHUFFLE,REASON_COST)
	g:DeleteGroup()
end
function s.regcon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetHandler():IsCode(53194323)
end
function s.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(s.efilter)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function s.efilter(e,te)
	return (te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner()) or (te:GetOwnerPlayer()~=e:GetOwnerPlayer() and te:IsActivated()
		and te:IsActiveType(TYPE_SPELL))
end

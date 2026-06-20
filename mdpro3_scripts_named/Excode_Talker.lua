--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 余码语者  (ID: 40669071)
-- Type: Monster / Effect / Link
-- Attribute: WIND
-- Race: Cyberse
-- ATK 2300 | LINK
-- Setcode: 257
--
-- Effect Text:
-- 电子界族怪兽2只以上
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡连接召唤成功时，指定额外怪兽区域的怪兽数量的没有使用的主要怪兽区域才能发动。指定的区域在这只怪兽表侧表示存在期间不能使用。
-- ②：这张卡所连接区的怪兽攻击力上升500，不会被效果破坏。
--[[ __CARD_HEADER_END__ ]]

--エクスコード・トーカー
function c40669071.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2)
	--lock zones
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40669071,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,40669071)
	e1:SetCondition(c40669071.lzcon)
	e1:SetTarget(c40669071.lztg)
	e1:SetOperation(c40669071.lzop)
	c:RegisterEffect(e1)
	--atk up/indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c40669071.tgtg)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c40669071.lzcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c40669071.lzfilter(c)
	return c:GetSequence()>4
end
function c40669071.lztg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c40669071.lzfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if chk==0 then return ct>0
		and Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)
			+Duel.GetLocationCount(1-tp,LOCATION_MZONE,PLAYER_NONE,0)>ct end
	local dis=Duel.SelectDisableField(tp,ct,LOCATION_MZONE,LOCATION_MZONE,0xe000e0)
	e:SetLabel(dis)
	Duel.Hint(HINT_ZONE,tp,dis)
end
function c40669071.lzop(e,tp,eg,ep,ev,re,r,rp)
	local zone=e:GetLabel()
	if tp==1 then
		zone=((zone&0xffff)<<16)|((zone>>16)&0xffff)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetValue(zone)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e:GetHandler():RegisterEffect(e1)
end
function c40669071.tgtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end

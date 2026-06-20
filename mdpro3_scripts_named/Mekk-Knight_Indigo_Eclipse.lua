--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 绀碧之机界骑士  (ID: 92204263)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Psychic
-- Level 8
-- ATK 2400 | DEF 2400
-- Setcode: 268
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：相同纵列有卡2张以上存在的场合，这张卡可以在那个纵列的自己场上特殊召唤。
-- ②：1回合1次，以自己场上1只「机界骑士」怪兽为对象才能发动。那只自己怪兽的位置向其他的自己的主要怪兽区域移动。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--紺碧の機界騎士
function c92204263.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,92204263+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c92204263.hspcon)
	e1:SetValue(c92204263.hspval)
	c:RegisterEffect(e1)
	--move
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92204263,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c92204263.seqtg)
	e2:SetOperation(c92204263.seqop)
	c:RegisterEffect(e2)
end
function c92204263.cfilter(c)
	return c:GetColumnGroupCount()>0
end
function c92204263.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=0
	local lg=Duel.GetMatchingGroup(c92204263.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	for tc in aux.Next(lg) do
		zone=bit.bor(zone,tc:GetColumnZone(LOCATION_MZONE,tp))
	end
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function c92204263.hspval(e,c)
	local tp=c:GetControler()
	local zone=0
	local lg=Duel.GetMatchingGroup(c92204263.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	for tc in aux.Next(lg) do
		zone=bit.bor(zone,tc:GetColumnZone(LOCATION_MZONE,tp))
	end
	return 0,zone
end
function c92204263.seqfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x10c)
end
function c92204263.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c92204263.seqfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c92204263.seqfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(92204263,1))
	Duel.SelectTarget(tp,c92204263.seqfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c92204263.seqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=math.log(s,2)
	Duel.MoveSequence(tc,nseq)
end

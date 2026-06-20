--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 健美操妖精Ξ  (ID: 83094004)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Fairy
-- Level 1
-- ATK 200 | DEF 200
--
-- Effect Text:
-- ①：1回合1次，以和这张卡相同纵列1只对方的表侧表示怪兽为对象才能发动。自己场上的这张卡的位置向其他的自己的主要怪兽区域移动，作为对象的对方怪兽的位置向这张卡的正对面的对方的主要怪兽区域移动。那之后，
-- 给那只对方怪兽放置1个燃烧指示物。这个效果在对方回合也能发动。
-- ②：只要这张卡在怪兽区域存在，有燃烧指示物放置的怪兽的攻击力·守备力下降那数量×200。
--[[ __CARD_HEADER_END__ ]]

--エアロピΞ
function c83094004.initial_effect(c)
	--sequence & move
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83094004,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMINGS_CHECK_MONSTER)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c83094004.seqtg)
	e1:SetOperation(c83094004.seqop)
	c:RegisterEffect(e1)
	--atk & def down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(c83094004.atkval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c83094004.seqfilter(c,e,tp)
	local g=e:GetHandler():GetColumnGroup()
	if not (c:IsFaceup() and g:IsContains(c) and c:IsCanAddCounter(0x105c,1)) then return false end
	for i=0,4 do
		local s1=Duel.CheckLocation(tp,LOCATION_MZONE,i)
		local s2=Duel.CheckLocation(1-tp,LOCATION_MZONE,4-i)
		if s1 and s2 then return true end
	end
	return false
end
function c83094004.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c83094004.seqfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)>0
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE,PLAYER_NONE,0)>0
		and Duel.IsExistingTarget(c83094004.seqfilter,tp,0,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c83094004.seqfilter,tp,0,LOCATION_MZONE,1,1,nil,e,tp)
end
function c83094004.seqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or c:IsControler(1-tp) or c:IsImmuneToEffect(e)
		or not tc:IsRelateToEffect(e) or tc:IsControler(tp) or tc:IsImmuneToEffect(e) then return end
	local filter=0
	for i=0,4 do
		local s1=Duel.CheckLocation(tp,LOCATION_MZONE,i)
		local s2=Duel.CheckLocation(1-tp,LOCATION_MZONE,4-i)
		if s1 and s2 then
			filter=filter|2^i
		end
	end
	if filter==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local flag=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,~filter)
	local seq1=math.log(flag,2)
	local seq2=4-math.log(flag,2)
	Duel.MoveSequence(c,seq1)
	if c:GetSequence()==seq1 then
		Duel.MoveSequence(tc,seq2)
		if tc:IsFaceup() then
			Duel.BreakEffect()
			tc:AddCounter(0x105c,1)
		end
	end
end
function c83094004.atkval(e,c)
	return c:GetCounter(0x105c)*-200
end

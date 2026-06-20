--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 耀圣之月诗 福尔图娜  (ID: 85976588)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 6
-- ATK 2200 | DEF 1800
-- Setcode: 472
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②③的效果1回合各能使用1次。
-- ①：这张卡可以从手卡往自己的中央的主要怪兽区域特殊召唤。
-- ②：自己主要阶段才能发动。从手卡·卡组把1张「耀圣」永续陷阱卡在自己场上表侧表示放置。
-- ③：对方回合才能发动。自己的主要怪兽区域的这张卡和中央的怪兽的位置交换。那之后，可以让场上1张表侧表示的魔法·陷阱卡回到手卡。
--[[ __CARD_HEADER_END__ ]]

--耀聖の月詩フォルトナ
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.spcon)
	e1:SetValue(s.spval)
	c:RegisterEffect(e1)
	--place
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.ptg)
	e2:SetOperation(s.pop)
	c:RegisterEffect(e2)
	--switch locations
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id+o)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END+TIMING_END_PHASE)
	e3:SetCondition(s.chcon)
	e3:SetTarget(s.chtg)
	e3:SetOperation(s.chop)
	c:RegisterEffect(e3)
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,0x4)>0
end
function s.spval(e,c)
	return 0,0x4
end
function s.pfilter(c,tp)
	return c:IsType(TYPE_CONTINUOUS) and c:IsType(TYPE_TRAP) and c:IsSetCard(0x1d8)
		and not c:IsForbidden() and c:CheckUniqueOnField(tp)
end
function s.ptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(s.pfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,tp) end
end
function s.pop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,s.pfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	if tc then Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) end
end
function s.chcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSequence()<5 and Duel.GetTurnPlayer()==1-tp
end
function s.chfilter(c)
	return c:GetSequence()==2
end
function s.chtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.chfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
end
function s.rthfilter(c)
	return c:IsFaceup() and c:IsAbleToHand() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function s.chop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cs=c:GetSequence()
	if not c:IsRelateToChain() or not c:IsControler(tp) or cs>4 or cs==2 then return end
	local g=Duel.GetMatchingGroup(s.chfilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==1 then
		local tc=g:GetFirst()
		Duel.SwapSequence(c,tc)
		if c:GetSequence()==cs then return end
		if Duel.IsExistingMatchingCard(s.rthfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
			local rg=Duel.SelectMatchingCard(tp,s.rthfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
			Duel.HintSelection(rg)
			Duel.SendtoHand(rg,nil,REASON_EFFECT)
		end
	end
end

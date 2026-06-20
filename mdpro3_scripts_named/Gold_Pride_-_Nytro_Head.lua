--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 黄金荣耀-氮氧头领  (ID: 59900655)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 8
-- ATK 2300 | DEF 2600
-- Setcode: 402
--
-- Effect Text:
-- 这个卡名的①②③的效果1回合各能使用1次。
-- ①：自己基本分比对方少的场合才能发动。这张卡从手卡特殊召唤。
-- ②：对方准备阶段才能发动。在对方场上把1只「氮氧衍生物」（炎族·炎·8星·攻/守0）特殊召唤。这衍生物不能作为连接素材。
-- ③：对方主要阶段，以场上1只「氮氧衍生物」为对象才能发动。那衍生物以及那些前面·后面·相邻的区域（怪兽区域·魔法与陷阱区域）存在的卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--GP－Nヘッド
local s,id,o=GetID()
function s.initial_effect(c)
	--spsummon self
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
	--spsummon token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.tkcon)
	e2:SetTarget(s.tktg)
	e2:SetOperation(s.tkop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id+o*2)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e3:SetCondition(s.descon)
	e3:SetTarget(s.destg)
	e3:SetOperation(s.desop)
	c:RegisterEffect(e3)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) end
end
function s.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function s.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id+o,0,TYPES_TOKEN_MONSTER,0,0,8,RACE_PYRO,ATTRIBUTE_FIRE,POS_FACEUP,1-tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,1-tp,0)
end
function s.tkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,id+o,0,TYPES_TOKEN_MONSTER,0,0,8,RACE_PYRO,ATTRIBUTE_FIRE,POS_FACEUP,1-tp) then return end
	local token=Duel.CreateToken(tp,id+o)
	if Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(1)
		token:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()==1-tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function s.dfilter(c)
	return c:IsCode(id+o) and c:IsFaceup()
end
function s.sfilter(c,p,seq,loc)
	local sseq=c:GetSequence()
	if c:IsControler(1-p) then
		return loc==LOCATION_MZONE and c:IsLocation(LOCATION_MZONE)
			and (sseq==5 and seq==3 or sseq==6 and seq==1)
	end
	if c:IsLocation(LOCATION_SZONE) then
		return sseq<5 and (sseq==seq or loc==LOCATION_SZONE and math.abs(sseq-seq)==1)
	end
	if sseq<5 then
		return sseq==seq or loc==LOCATION_MZONE and math.abs(sseq-seq)==1
	else
		return loc==LOCATION_MZONE and (sseq==5 and seq==1 or sseq==6 and seq==3)
	end
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and s.dfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local tc=Duel.SelectTarget(tp,s.dfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil):GetFirst()
	local g=Duel.GetMatchingGroup(s.sfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,tc:GetControler(),tc:GetSequence(),tc:GetLocation())
	g:AddCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(s.sfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,tc,tc:GetControler(),tc:GetSequence(),tc:GetLocation())
		g:AddCard(tc)
		Duel.Destroy(g,REASON_EFFECT)
	end
end

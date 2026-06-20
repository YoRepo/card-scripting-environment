--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 霰弹弹丸龙  (ID: 5087128)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 2
-- ATK 1100 | DEF 2000
-- Setcode: 258
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：场上的这张卡为对象的连接怪兽的效果发动时才能发动。这张卡破坏。那之后，选和这张卡存在过的区域相同纵列1只怪兽破坏，那些相邻区域有怪兽存在的场合，那些也破坏。
-- ②：场上的这张卡被战斗·效果破坏送去墓地的回合的结束阶段才能发动。从卡组把「霰弹弹丸龙」以外的1只「弹丸」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--シェルヴァレット・ドラゴン
function c5087128.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5087128,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,5087128)
	e1:SetCondition(c5087128.descon)
	e1:SetTarget(c5087128.destg)
	e1:SetOperation(c5087128.desop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c5087128.regop)
	c:RegisterEffect(e2)
end
function c5087128.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsContains(c) then return false end
	return re:IsActiveType(TYPE_LINK)
end
function c5087128.desfilter(c,g)
	return g:IsContains(c)
end
function c5087128.desfilter2(c,s,tp)
	local seq=c:GetSequence()
	return seq<5 and math.abs(seq-s)==1 and c:IsControler(tp)
end
function c5087128.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c5087128.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c:GetColumnGroup())
	if chk==0 then return c:IsDestructable() and g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c5087128.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lg=c:GetColumnGroup()
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)>0 then
		local g=Duel.GetMatchingGroup(c5087128.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,lg)
		if g:GetCount()==0 then return end
		Duel.BreakEffect()
		local tc=nil
		if g:GetCount()==1 then
			tc=g:GetFirst()
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			tc=g:Select(tp,1,1,nil):GetFirst()
		end
		local seq=tc:GetSequence()
		local dg=Group.CreateGroup()
		if seq<5 then dg=Duel.GetMatchingGroup(c5087128.desfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,seq,tc:GetControler()) end
		if Duel.Destroy(tc,REASON_EFFECT)~=0 and dg:GetCount()>0 then
			Duel.Destroy(dg,REASON_EFFECT)
		end
	end
end
function c5087128.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_ONFIELD) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(5087128,1))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1,5087129)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTarget(c5087128.sptg)
		e1:SetOperation(c5087128.spop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c5087128.spfilter(c,e,tp)
	return c:IsSetCard(0x102) and not c:IsCode(5087128) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c5087128.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c5087128.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c5087128.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c5087128.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end

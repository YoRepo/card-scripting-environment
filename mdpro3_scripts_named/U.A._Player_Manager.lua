--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 超级运动员 球员兼领队  (ID: 47021196)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 8
-- ATK 2000 | DEF 2600
-- Setcode: 178
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己对「超级运动员」怪兽的召唤·特殊召唤成功的场合才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡特殊召唤成功的场合，可以从以下效果选择1个发动。
-- ●以场上1张卡为对象才能发动。那张卡破坏。
-- ●「超级运动员」怪兽以外的场上的全部表侧表示怪兽的效果直到回合结束时无效。
--[[ __CARD_HEADER_END__ ]]

--U.A.プレイングマネージャー
function c47021196.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47021196,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,47021196)
	e1:SetCondition(c47021196.spcon)
	e1:SetTarget(c47021196.sptg)
	e1:SetOperation(c47021196.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--destroy/disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,47021197)
	e3:SetTarget(c47021196.target)
	e3:SetOperation(c47021196.operation)
	c:RegisterEffect(e3)
end
function c47021196.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xb2) and c:IsSummonPlayer(tp)
end
function c47021196.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c47021196.cfilter,1,nil,tp)
end
function c47021196.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c47021196.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c47021196.negfilter(c)
	return aux.NegateMonsterFilter(c) and not c:IsSetCard(0xb2)
end
function c47021196.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	local b1=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local b2=Duel.GetMatchingGroup(c47021196.negfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if chk==0 then return #b1>0 or #b2>0 end
	local off=1
	local ops={}
	local opval={}
	if #b1>0 then
		ops[off]=aux.Stringid(47021196,1)
		opval[off]=0
		off=off+1
	end
	if #b2>0 then
		ops[off]=aux.Stringid(47021196,2)
		opval[off]=1
		off=off+1
	end
	local op=Duel.SelectOption(tp,table.unpack(ops))+1
	local sel=opval[op]
	e:SetLabel(sel)
	if sel==0 then
		e:SetCategory(CATEGORY_DESTROY)
		e:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	else
		e:SetCategory(CATEGORY_DISABLE)
		e:SetProperty(EFFECT_FLAG_DELAY)
	end
end
function c47021196.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToEffect(e) then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	else
		local c=e:GetHandler()
		local b2=Duel.GetMatchingGroup(c47021196.negfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		local nc=b2:GetFirst()
		while nc do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			nc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			nc:RegisterEffect(e2)
			nc=b2:GetNext()
		end
	end
end

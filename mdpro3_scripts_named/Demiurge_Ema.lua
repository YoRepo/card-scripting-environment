--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 造物主 埃玛  (ID: 26364381)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 8
-- ATK 3300 | DEF 2000
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：从自己的手卡·卡组·场上（表侧表示）把4只攻击力2400以上而守备力1000的怪兽送去墓地才能发动。这张卡从手卡特殊召唤。
-- ②：以自己以及对方场上的魔法·陷阱卡各1张为对象才能发动。那些卡破坏。那之后，在双方场上把「人工生命体衍生物」（天使族·光·2星·攻/守800）各1只守备表示特殊召唤，这张卡的攻击力上升1600。
--[[ __CARD_HEADER_END__ ]]

--デミウルゴスEMA
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.spcost)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
end
function s.sprfilter(c)
	return c:IsFaceupEx() and c:IsAbleToGraveAsCost()
		and c:IsAttackAbove(2400) and c:IsDefense(1000)
end
function s.gcheck(g,tp)
	return Duel.GetMZoneCount(tp,g)>0
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(s.sprfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_MZONE,0,e:GetHandler())
	if chk==0 then return g:CheckSubGroup(s.gcheck,4,4,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,s.gcheck,false,4,4,tp)
	Duel.SendtoGrave(sg,REASON_COST)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function s.desfilter(c,e)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and Duel.GetMZoneCount(c:GetControler(),c)>0
		and c:IsCanBeEffectTarget(e)
end
function s.gcheck2(g,tp)
	return g:FilterCount(Card.IsControler,nil,tp)==g:FilterCount(Card.IsControler,nil,1-tp)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(s.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,e)
	if chk==0 then return g:CheckSubGroup(s.gcheck2,2,2,tp)
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id+o,0,TYPES_TOKEN_MONSTER,800,800,2,RACE_FAIRY,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id+o,0,TYPES_TOKEN_MONSTER,800,800,2,RACE_FAIRY,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE,1-tp) end
	local sg=g:SelectSubGroup(tp,s.gcheck2,false,2,2,tp)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,#sg,0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetTargetsRelateToChain():Filter(Card.IsOnField,nil)
	if g:GetCount()>0 and Duel.Destroy(g,REASON_EFFECT)>0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
			or Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0
			or not Duel.IsPlayerCanSpecialSummonMonster(tp,id+o,0,TYPES_TOKEN_MONSTER,800,800,2,RACE_FAIRY,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE)
			or not Duel.IsPlayerCanSpecialSummonMonster(tp,id+o,0,TYPES_TOKEN_MONSTER,800,800,2,RACE_FAIRY,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE,1-tp)
			or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
		local token1=Duel.CreateToken(tp,id+o)
		local token2=Duel.CreateToken(tp,id+o)
		Duel.BreakEffect()
		Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		Duel.SpecialSummonStep(token2,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
		Duel.SpecialSummonComplete()
		if c:IsFaceup() and c:IsRelateToChain() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(1600)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
			c:RegisterEffect(e1)
		end
	end
end

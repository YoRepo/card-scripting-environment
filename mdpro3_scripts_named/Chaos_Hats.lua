--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 混沌礼帽  (ID: 2372506)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 207
--
-- Effect Text:
-- ①：对方把怪兽的效果·通常魔法·通常陷阱卡发动时才能发动。从卡组把3张卡名不同的魔法·陷阱卡作为卡名当作「混沌礼帽」使用的通常怪兽（魔法师族·暗·8星·攻/守0），和有「光与暗的仪式」的卡名记述的自己
-- 的主要怪兽区域1只怪兽混合洗切并里侧守备表示盖放。那之后，那个对方发动的效果变成「对方场上1只里侧守备表示怪兽破坏」。
--[[ __CARD_HEADER_END__ ]]

--カオスシルクハット
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,33599853)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandlerPlayer()~=1-tp then return false end
	local rc=re:GetHandler()
	return ((rc:GetType()==TYPE_TRAP or rc:GetType()==TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE)) or re:IsActiveType(TYPE_MONSTER)
end
function s.filter(c)
	return aux.IsCodeListed(c,33599853) and c:GetSequence()<5 and c:IsCanTurnSet()
end
function s.spfilter(c,e,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id,0xcf,TYPES_NORMAL_TRAP_MONSTER,0,0,8,RACE_SPELLCASTER,ATTRIBUTE_DARK)
		and c:IsCanBeSpecialSummoned(e,0,tp,true,true,POS_FACEDOWN_DEFENSE)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_MZONE,0,1,nil)
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and g:GetClassCount(Card.GetCode)>=3
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 then return end
	local g=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if not g:CheckSubGroup(aux.dncheck,3,3) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g2:GetFirst()
	if not tc or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,3,3)
	if not sg or sg:GetCount()~=3 then return end
	Duel.HintSelection(g2)
	if tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
		local ce=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_EFFECT)
		tc:ReleaseEffectRelation(ce)
	end
	for sc in aux.Next(sg) do
		Duel.SpecialSummonStep(sc,0,tp,tp,true,true,POS_FACEDOWN_DEFENSE)
		local e1=Effect.CreateEffect(sc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		sc:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_LEVEL)
		e2:SetValue(8)
		sc:RegisterEffect(e2,true)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_RACE)
		e3:SetValue(RACE_SPELLCASTER)
		sc:RegisterEffect(e3,true)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e4:SetValue(ATTRIBUTE_DARK)
		sc:RegisterEffect(e4,true)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_SET_BASE_ATTACK)
		e5:SetValue(0)
		sc:RegisterEffect(e5,true)
		local e6=e1:Clone()
		e6:SetCode(EFFECT_SET_BASE_DEFENSE)
		e6:SetValue(0)
		sc:RegisterEffect(e6,true)
		local e7=e1:Clone()
		e7:SetCode(EFFECT_CHANGE_CODE)
		e7:SetValue(id)
		sc:RegisterEffect(e7,true)
	end
	Duel.SpecialSummonComplete()
	Duel.ConfirmCards(1-tp,sg)
	sg:AddCard(tc)
	Duel.ShuffleSetCard(sg)
	local tg=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,tg)
	Duel.ChangeChainOperation(ev,s.repop)
end
function s.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsFacedown,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end

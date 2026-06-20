--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 真龙凰骑 玛丽亚姆内·悖论  (ID: 58205203)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Wyrm
-- Level 6
-- ATK 1800 | DEF 1400
-- Setcode: 249
--
-- Effect Text:
-- 这张卡表侧表示上级召唤的场合，可以作为怪兽的代替而把自己场上的永续魔法·永续陷阱卡解放。这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡在手卡存在的场合才能发动。这张卡以外的自己的手卡·场上（表侧表示）1张「真龙」卡破坏，这张卡在自己或对方的场上特殊召唤。
-- ②：这张卡从手卡召唤·特殊召唤的场合发动。从自己卡组上面把4张卡除外。
--[[ __CARD_HEADER_END__ ]]

--真竜凰騎マリアムネP
local s,id,o=GetID()
function s.initial_effect(c)
	--summon with s/t
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_ADD_EXTRA_TRIBUTE)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_CONTINUOUS))
	e1:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e1)
	--spsummon self
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.spstg)
	e2:SetOperation(s.spsop)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCountLimit(1,id+o)
	e3:SetCondition(s.rmcon)
	e3:SetTarget(s.rmtg)
	e3:SetOperation(s.rmop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function s.desfilter(c,tp,sc,e,chk)
	return c:IsFaceupEx() and c:IsSetCard(0xf9) and
		(not chk
			or Duel.GetMZoneCount(tp,c)>0 and sc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			or Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and sc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp))
end
function s.spstg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(s.desfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,c,tp,c,e,true)
	if chk==0 then return #g>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spsop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=nil
	if Duel.IsExistingMatchingCard(s.desfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,aux.ExceptThisCard(e),tp,c,e,true) then
		dg=Duel.GetMatchingGroup(s.desfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,aux.ExceptThisCard(e),tp,c,e,true)
	else
		dg=Duel.GetMatchingGroup(s.desfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,aux.ExceptThisCard(e),tp,c,e,false)
	end
	local g=dg:Select(tp,1,1,aux.ExceptThisCard(e))
	if g:FilterCount(Card.IsLocation,nil,LOCATION_ONFIELD)>0 then
		Duel.HintSelection(g)
	end
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		Duel.AdjustAll()
		if not c:IsRelateToChain() or (not c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)) then return end
		local b1=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		local b2=Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
		local toplayer=aux.SelectFromOptions(tp,
			{b1,aux.Stringid(id,2),tp},
			{b2,aux.Stringid(id,3),1-tp})
		if toplayer~=nil then
			Duel.SpecialSummon(c,0,tp,toplayer,false,false,POS_FACEUP)
		else
			if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then
				Duel.SendtoGrave(c,REASON_RULE)
			end
		end
	end
end
function s.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonLocation(LOCATION_HAND)
end
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local rg=Duel.GetDecktopGroup(tp,4)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,rg,4,0,0)
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local rg=Duel.GetDecktopGroup(tp,4)
	Duel.DisableShuffleCheck()
	Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
end

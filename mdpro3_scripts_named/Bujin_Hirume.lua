--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 武神-日孁  (ID: 9418365)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level 4
-- ATK 2000 | DEF 1000
-- Setcode: 136
--
-- Effect Text:
-- 这张卡不能通常召唤。把「武神-日孁」以外的自己墓地1只名字带有「武神」的怪兽从游戏中除外的场合可以特殊召唤。此外，这个方法特殊召唤的这张卡被对方破坏送去墓地的场合才能发动。自己丢弃1张手卡。那之后，对
-- 方选1张手卡丢弃。「武神-日孁」在自己场上只能有1只表侧表示存在。
--[[ __CARD_HEADER_END__ ]]

--武神－ヒルメ
function c9418365.initial_effect(c)
	c:SetUniqueOnField(1,0,9418365)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9418365,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetValue(SUMMON_VALUE_SELF)
	e1:SetCondition(c9418365.spcon)
	e1:SetTarget(c9418365.sptg)
	e1:SetOperation(c9418365.spop)
	c:RegisterEffect(e1)
	--discard
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9418365,1))
	e2:SetCategory(CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c9418365.hdcon)
	e2:SetTarget(c9418365.hdtg)
	e2:SetOperation(c9418365.hdop)
	c:RegisterEffect(e2)
end
function c9418365.spfilter(c)
	return c:IsSetCard(0x88) and c:IsType(TYPE_MONSTER) and not c:IsCode(9418365) and c:IsAbleToRemoveAsCost()
end
function c9418365.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c9418365.spfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c9418365.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c9418365.spfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c9418365.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
end
function c9418365.hdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF and rp==1-tp and c:IsReason(REASON_DESTROY)
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
end
function c9418365.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,1)
end
function c9418365.hdop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)~=0 then
		Duel.BreakEffect()
		Duel.DiscardHand(1-tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	end
end

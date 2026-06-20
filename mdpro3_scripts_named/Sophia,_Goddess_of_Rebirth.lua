--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 创星神 索菲娅  (ID: 4335427)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Fairy
-- Level 11
-- ATK 3600 | DEF 3400
--
-- Effect Text:
-- 这张卡不能通常召唤。把自己·对方场上表侧表示存在的仪式·融合·同调·超量怪兽各1只从游戏中除外的场合才能特殊召唤。这张卡的特殊召唤不会被无效化。这张卡特殊召唤成功时，这张卡以外的双方的手卡·场上·墓地
-- 的卡全部从游戏中除外。不能对应这个效果的发动让魔法·陷阱·效果怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--創星神 sophia
function c4335427.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c4335427.spcon)
	e1:SetTarget(c4335427.sptg)
	e1:SetOperation(c4335427.spop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e2)
	--cannot special summon
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	--remove
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(4335427,0))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetTarget(c4335427.rmtg)
	e4:SetOperation(c4335427.rmop)
	c:RegisterEffect(e4)
end
c4335427.spchecks=aux.CreateChecks(Card.IsType,{TYPE_RITUAL,TYPE_FUSION,TYPE_SYNCHRO,TYPE_XYZ})
function c4335427.spcostfilter(c)
	return c:IsFaceup() and c:IsAbleToRemoveAsCost() and c:IsType(TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ)
end
function c4335427.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c4335427.spcostfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	return g:CheckSubGroupEach(c4335427.spchecks,aux.mzctcheck,tp)
end
function c4335427.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c4335427.spcostfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=g:SelectSubGroupEach(tp,c4335427.spchecks,true,aux.mzctcheck,tp)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c4335427.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c4335427.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c4335427.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE,aux.ExceptThisCard(e))
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 邪恶★双子星 姬丝基勒·璃拉  (ID: 62098216)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 2200 | DEF 2200
-- Setcode: 1456016073041
--
-- Effect Text:
-- 这张卡不能通常召唤。把自己场上2只连接怪兽解放的场合才能从手卡·墓地特殊召唤。这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡特殊召唤的场合才能发动。对方在自身场上的卡是3张以上的场合直到变成2张为止必须送去墓地。
-- ②：只要自己墓地有「姬丝基勒」怪兽以及「璃拉」怪兽存在，这张卡的攻击力·守备力上升2200。
--[[ __CARD_HEADER_END__ ]]

--Evil★Twins キスキル・リィラ
function c62098216.initial_effect(c)
	c:EnableReviveLimit()
	--special summon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e0)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCondition(c62098216.sprcon)
	e1:SetTarget(c62098216.sprtg)
	e1:SetOperation(c62098216.sprop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(62098216,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,62098216)
	e2:SetTarget(c62098216.tgtg)
	e2:SetOperation(c62098216.tgop)
	c:RegisterEffect(e2)
	--atk/def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c62098216.con)
	e3:SetValue(2200)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
end
function c62098216.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(Card.IsType,nil,TYPE_LINK)
	return rg:CheckSubGroup(aux.mzctcheckrel,2,2,tp,REASON_SPSUMMON)
end
function c62098216.sprtg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local rg=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(Card.IsType,nil,TYPE_LINK)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=rg:SelectSubGroup(tp,aux.mzctcheckrel,true,2,2,tp,REASON_SPSUMMON)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c62098216.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c62098216.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
	local ct=g:GetCount()-2
	if chk==0 then return Duel.IsPlayerCanSendtoGrave(1-tp) and ct>0 and g:IsExists(Card.IsAbleToGrave,1,nil,1-tp,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,ct,0,0)
end
function c62098216.tgop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanSendtoGrave(1-tp) then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
	local ct=g:GetCount()-2
	if ct>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local sg=g:FilterSelect(1-tp,Card.IsAbleToGrave,ct,ct,nil,1-tp,nil)
		Duel.SendtoGrave(sg,REASON_RULE)
	end
end
function c62098216.cfilter(c,setcode)
	return c:IsFaceup() and c:IsSetCard(setcode)
end
function c62098216.con(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c62098216.cfilter,tp,LOCATION_GRAVE,0,1,nil,0x152)
		and Duel.IsExistingMatchingCard(c62098216.cfilter,tp,LOCATION_GRAVE,0,1,nil,0x153)
end

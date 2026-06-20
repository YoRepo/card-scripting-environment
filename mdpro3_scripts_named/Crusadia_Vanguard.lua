--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 圣像骑士的圣战  (ID: 55312487)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 278
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：这张卡也能把自己场上1只「圣像骑士」怪兽或者「星遗物」怪兽解放来发动。那个场合，从自己的卡组·墓地选原本卡名和那只怪兽不同的1只「圣像骑士」怪兽或者「星遗物」怪兽特殊召唤。
-- ②：只要自己场上有「圣像骑士」连接怪兽存在，对方只能选择连接怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--クルセイド・パラディオン
function c55312487.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,55312487+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c55312487.target)
	c:RegisterEffect(e1)
	--atk limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c55312487.atcon)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetValue(c55312487.atlimit)
	c:RegisterEffect(e3)
end
function c55312487.spfilter1(c,e,tp)
	return c:IsSetCard(0xfe,0x116) and c:IsType(TYPE_MONSTER) and Duel.GetMZoneCount(tp,c)>0
		and Duel.IsExistingMatchingCard(c55312487.spfilter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp,c)
end
function c55312487.spfilter2(c,e,tp,rc)
	return c:IsSetCard(0xfe,0x116) and c:IsType(TYPE_MONSTER) and not c:IsOriginalCodeRule(rc:GetOriginalCodeRule())
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c55312487.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.CheckReleaseGroup(tp,c55312487.spfilter1,1,nil,e,tp)
		and Duel.SelectEffectYesNo(tp,e:GetHandler(),aux.Stringid(55312487,0)) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e:SetOperation(c55312487.activate)
		local rg=Duel.SelectReleaseGroup(tp,c55312487.spfilter1,1,1,nil,e,tp)
		e:SetLabelObject(rg:GetFirst())
		Duel.Release(rg,REASON_COST)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c55312487.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local rc=e:GetLabelObject()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c55312487.spfilter2),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp,rc)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c55312487.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x116) and c:IsType(TYPE_LINK)
end
function c55312487.atcon(e)
	return Duel.IsExistingMatchingCard(c55312487.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c55312487.atlimit(e,c)
	return c:IsFacedown() or not c:IsType(TYPE_LINK)
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 书灵师实体化  (ID: 15590355)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 380
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：把手卡1只「书灵师」仪式怪兽给对方观看才能发动。把持有和给人观看的怪兽的等级相同等级的1只「炽火衍生物」（电子界族·炎·攻/守0）在自己场上特殊召唤。只要这个效果特殊召唤的衍生物在自己场上存在，自
-- 己不是「书灵师」怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--リブロマンサー・リアライズ
local s,id,o=GetID()
function s.initial_effect(c)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1,id)
	e1:SetLabel(0)
	e1:SetCost(s.cost)
	e1:SetTarget(s.tg)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
end
function s.cfilter(c,tp)
	return c:IsSetCard(0x17c) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_RITUAL) and not c:IsPublic()
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id+o,0,TYPES_TOKEN_MONSTER,0,0,c:GetLevel(),RACE_CYBERSE,ATTRIBUTE_FIRE)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_HAND,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local tc=Duel.SelectMatchingCard(tp,s.cfilter,tp,LOCATION_HAND,0,1,1,nil,tp):GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	e:SetLabel(tc:GetLevel())
	Duel.ShuffleHand(tp)
end
function s.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local res=e:GetLabel()==100
		e:SetLabel(0)
		return res and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	local lv=e:GetLabel()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,id+o,0,TYPES_TOKEN_MONSTER,0,0,lv,RACE_CYBERSE,ATTRIBUTE_FIRE) then
		local tk=Duel.CreateToken(tp,id+o)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
		e1:SetValue(lv)
		tk:RegisterEffect(e1,true)
		Duel.SpecialSummonStep(tk,0,tp,tp,false,false,POS_FACEUP)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetRange(LOCATION_MZONE)
		e2:SetAbsoluteRange(tp,1,0)
		e2:SetCondition(s.splimitcon)
		e2:SetTarget(s.splimit)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tk:RegisterEffect(e2,true)
		Duel.SpecialSummonComplete()
	end
end
function s.splimitcon(e)
	return e:GetHandlerPlayer()==e:GetOwnerPlayer()
end
function s.splimit(e,c)
	return not c:IsSetCard(0x17c)
end

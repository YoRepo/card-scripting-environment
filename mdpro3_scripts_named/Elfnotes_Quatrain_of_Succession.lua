--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 耀圣之诗～继唱之四行体～  (ID: 58809685)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 472
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：自己的中央的主要怪兽区域的怪兽不能用对方的效果除外。
-- ②：从自己的手卡·场上把这张卡以外的1张魔法·陷阱卡送去墓地，宣言1～4的任意等级才能发动。把持有宣言的等级的1只「极花之大耀圣衍生物」（植物族·调整·炎·攻/守0）在自己场上特殊召唤。只要这个效果特
-- 殊召唤的衍生物存在，自己不是「耀圣」怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--エルフェンノーツ～継唱のクウォートレイン～
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Cannot Banish
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_REMOVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(s.rmlimit)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCountLimit(1,id)
	e3:SetCost(s.spcost)
	e3:SetTarget(s.sptg)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)
end
function s.rmlimit(e,c,rp,r,re)
	local tp=e:GetHandlerPlayer()
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:GetSequence()==2
		and r&REASON_EFFECT~=0 and r&REASON_REDIRECT==0 and rp==1-tp
end
function s.cfilter(c,tp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and Duel.GetMZoneCount(tp,c)>0 and c:IsAbleToGraveAsCost()
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.cfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,e:GetHandler(),tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lvt={}
	for i=1,4 do
		if Duel.IsPlayerCanSpecialSummonMonster(tp,id+o,0x1d8,TYPES_TOKEN_MONSTER,0,0,i,RACE_PLANT,ATTRIBUTE_FIRE) then
			lvt[i]=i
		end
	end
	if chk==0 then
		if e:IsCostChecked() then
			return next(lvt)~=nil
		else
			return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
				and next(lvt)~=nil
		end
	end
	local pc=1
	for i=1,4 do
		if lvt[i] then lvt[i]=nil lvt[pc]=i pc=pc+1 end
	end
	lvt[pc]=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINGMSG_LVRANK)
	e:SetLabel(Duel.AnnounceNumber(tp,table.unpack(lvt)))
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local lv=e:GetLabel()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,id+o,0x1d8,TYPES_TOKEN_MONSTER,0,0,lv,RACE_PLANT,ATTRIBUTE_FIRE) then return end
	local token=Duel.CreateToken(tp,id+o)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
	e1:SetValue(lv)
	token:RegisterEffect(e1,true)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetAbsoluteRange(tp,1,0)
	e2:SetTarget(s.splimit)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	token:RegisterEffect(e2,true)
	Duel.SpecialSummonComplete()
end
function s.splimit(e,c)
	return not c:IsSetCard(0x1d8) and c:IsLocation(LOCATION_EXTRA)
end

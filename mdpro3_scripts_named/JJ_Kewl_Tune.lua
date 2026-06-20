--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 点唱机酒吧“杀手级调整曲”  (ID: 14442329)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 469
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：自己在通常召唤外加上只有1次，自己主要阶段可以把1只调整召唤。
-- ②：只要对方的场上或墓地有调整存在，自己场上的「杀手级调整曲响度战争」的攻击力上升3300。
-- ③：把自己场上1只调整解放才能发动。从卡组选1只「杀手级调整曲」怪兽加入手卡或特殊召唤。这个效果的发动后，直到回合结束时自己不是调整不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ジュークジョイント“Killer Tune”
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,41069676)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TUNER))
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsCode,41069676))
	e3:SetCondition(s.atkcon)
	e3:SetValue(3300)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCountLimit(1,id)
	e4:SetCost(s.spcost)
	e4:SetTarget(s.sptg)
	e4:SetOperation(s.spop)
	c:RegisterEffect(e4)
end
function s.cfilter(c)
	return c:IsFaceupEx() and c:IsType(TYPE_TUNER)
end
function s.atkcon(e)
	return Duel.IsExistingMatchingCard(s.cfilter,e:GetHandler():GetControler(),0,LOCATION_MZONE+LOCATION_GRAVE,1,nil)
end
function s.cfilter2(c,e,tp)
	return c:IsType(TYPE_TUNER)
		and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil,e,tp,c)
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,s.cfilter2,1,nil,e,tp) end
	local g=Duel.SelectReleaseGroup(tp,s.cfilter2,1,1,nil,e,tp)
	Duel.Release(g,REASON_COST)
end
function s.thfilter(c,e,tp,ec)
	if not (c:IsSetCard(0x1d5) and c:IsType(TYPE_MONSTER)) then return false end
	local res=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		or ec and Duel.GetMZoneCount(tp,ec)>0
	return c:IsAbleToHand() or (res and c:IsCanBeSpecialSummoned(e,0,tp,false,false))
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked() or not e:IsCostChecked()
		and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil,e,tp,nil) end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,nil)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local tc=g:GetFirst()
	if tc then
		if tc:IsAbleToHand() and (not tc:IsCanBeSpecialSummoned(e,0,tp,false,false) or ft<=0 or Duel.SelectOption(tp,1190,1152)==0) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		elseif tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(s.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function s.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:GetOriginalType()&TYPE_TUNER==0
end

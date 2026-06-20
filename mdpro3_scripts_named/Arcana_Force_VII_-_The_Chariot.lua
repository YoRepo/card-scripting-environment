--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 秘仪之力7-战车  (ID: 34568403)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1700 | DEF 1700
-- Setcode: 5
--
-- Effect Text:
-- 这张卡召唤·反转召唤·特殊召唤成功时，进行1次投掷硬币得到以下效果。
-- ●表：这张卡战斗破坏对方怪兽的场合，可以把那只怪兽在自己场上特殊召唤。
-- ●里：这张卡的控制权转移给对方。
--[[ __CARD_HEADER_END__ ]]

--アルカナフォースⅦ－THE CHARIOT
function c34568403.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34568403,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(aux.ArcanaCoinTarget)
	e1:SetOperation(c34568403.coinop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--coin effect
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(34568403,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetCondition(c34568403.spcon)
	e4:SetTarget(c34568403.sptg)
	e4:SetOperation(c34568403.spop)
	c:RegisterEffect(e4)
end
function c34568403.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local res=0
	local toss=false
	if Duel.IsPlayerAffectedByEffect(tp,73206827) then
		res=1-Duel.SelectOption(tp,60,61)
	else
		res=Duel.TossCoin(tp,1)
		toss=true
	end
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	if toss then
		c:RegisterFlagEffect(FLAG_ID_REVERSAL_OF_FATE,RESET_EVENT+RESETS_STANDARD,0,1)
	end
	c:RegisterFlagEffect(FLAG_ID_ARCANA_COIN,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,res,63-res)
	if res==0 then
		Duel.GetControl(c,1-tp)
	end
end
function c34568403.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetFlagEffectLabel(FLAG_ID_ARCANA_COIN)==1 and c:IsRelateToBattle() and c:IsStatus(STATUS_OPPO_BATTLE)
end
function c34568403.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	if chk==0 then return tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and ((tc:IsLocation(LOCATION_GRAVE) or tc:IsLocation(LOCATION_REMOVED) and tc:IsFaceup()) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			or tc:IsLocation(LOCATION_EXTRA) and tc:IsFaceup() and Duel.GetLocationCountFromEx(tp,tp,nil,tc)>0) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
end
function c34568403.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 剑斗兽 德拉伽塞斯  (ID: 62000467)
-- Type: Monster / Effect / Link
-- Attribute: WIND
-- Race: Winged Beast
-- ATK 2000 | LINK
-- Setcode: 4121
--
-- Effect Text:
-- 「剑斗兽」怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：自己的「剑斗兽」怪兽攻击的场合，那只怪兽不会被那次战斗破坏，对方直到伤害步骤结束时魔法·陷阱·怪兽的效果不能发动。
-- ②：这张卡进行战斗的战斗阶段结束时让这张卡回到持有者的额外卡组才能发动。从卡组把2只「剑斗兽」怪兽特殊召唤（同名卡最多1张）。
--[[ __CARD_HEADER_END__ ]]

--剣闘獣ドラガシス
function c62000467.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x1019),2,2)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c62000467.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(1)
	e2:SetCondition(c62000467.actcon)
	c:RegisterEffect(e2)
	--special summon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(62000467,0))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1,62000467)
	e6:SetCondition(c62000467.spcon)
	e6:SetCost(c62000467.spcost)
	e6:SetTarget(c62000467.sptg)
	e6:SetOperation(c62000467.spop)
	c:RegisterEffect(e6)
end
function c62000467.indtg(e,c)
	return c:IsSetCard(0x1019) and Duel.GetAttacker()==c
end
function c62000467.actcon(e)
	local tc=Duel.GetAttacker()
	local tp=e:GetHandlerPlayer()
	return tc and tc:IsControler(tp) and tc:IsSetCard(0x1019)
end
function c62000467.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0
end
function c62000467.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToExtraAsCost() end
	Duel.SendtoDeck(c,nil,SEQ_DECKTOP,REASON_COST)
end
function c62000467.spfilter(c,e,tp)
	return c:IsSetCard(0x1019) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c62000467.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if e:GetHandler():GetSequence()<5 then ft=ft+1 end
		local g=Duel.GetMatchingGroup(c62000467.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
		return ft>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and g:GetClassCount(Card.GetCode)>=2
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c62000467.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c62000467.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>=2 and g:GetClassCount(Card.GetCode)>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g:SelectSubGroup(tp,aux.dncheck,false,2,2)
		local tc=sg1:GetFirst()
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,0,0)
		tc=sg1:GetNext()
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,0,0)
		Duel.SpecialSummonComplete()
	end
end

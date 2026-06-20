--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 圣天树之大精灵  (ID: 65285459)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Plant
-- ATK 0 | LINK
-- Setcode: 8536
--
-- Effect Text:
-- 植物族怪兽2只以上
-- ①：这张卡不会被作为攻击对象（自己场上只有被这个效果适用的怪兽存在的状态中对方的攻击变成对自己的直接攻击）。
-- ②：1回合最多3次，自己因战斗·效果受到伤害的场合才能发动。自己基本分回复那个数值，从额外卡组把1只「圣蔓」怪兽特殊召唤。
-- ③：1回合1次，这所连接区的怪兽成为攻击对象时才能发动。攻击无效，那只自己怪兽的位置向其他的自己的主要怪兽区域移动。
--[[ __CARD_HEADER_END__ ]]

--聖天樹の大精霊
function c65285459.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c65285459.mfilter,2,99)
	c:EnableReviveLimit()
	--cannot be battle traget
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65285459,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(3)
	e2:SetCondition(c65285459.spcon)
	e2:SetTarget(c65285459.sptg)
	e2:SetOperation(c65285459.spop)
	c:RegisterEffect(e2)
	--negate attack
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(65285459,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BE_BATTLE_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c65285459.mvcon)
	e4:SetTarget(c65285459.mvtg)
	e4:SetOperation(c65285459.mvop)
	c:RegisterEffect(e4)
end
function c65285459.mfilter(c)
	return c:IsLinkRace(RACE_PLANT)
end
function c65285459.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c65285459.spfilter(c,e,tp)
	return c:IsSetCard(0x1158) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c65285459.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65285459.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,1,tp,ev)
end
function c65285459.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Recover(tp,ev,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c65285459.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		if #g>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c65285459.mvcon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and e:GetHandler():GetLinkedGroup():IsContains(d)
end
function c65285459.mvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)>0 end
end
function c65285459.mvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	if Duel.NegateAttack() and Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
		local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
		local nseq=math.log(s,2)
		Duel.MoveSequence(tc,nseq)
	end
end

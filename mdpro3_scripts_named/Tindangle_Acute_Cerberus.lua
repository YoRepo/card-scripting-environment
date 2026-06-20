--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 廷达魔三角之锐角地狱犬  (ID: 75119040)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Fiend
-- ATK 0 | LINK
-- Setcode: 267
--
-- Effect Text:
-- 「廷达魔三角」怪兽3只
-- ①：自己墓地有包含「廷达魔三角之底边守卫者」的「廷达魔三角」怪兽3种类以上存在的场合，这张卡的攻击力上升3000。
-- ②：这张卡的攻击力上升这张卡所连接区的「廷达魔三角」怪兽数量×500。
-- ③：这张卡攻击宣言的战斗阶段结束时才能发动。在自己场上把1只「廷达魔三角衍生物」（恶魔族·暗·1星·攻/守0）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ティンダングル・アキュート・ケルベロス
function c75119040.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x10b),3,3)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c75119040.atkcon)
	e1:SetValue(3000)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c75119040.atkval)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(75119040,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c75119040.spcon)
	e3:SetTarget(c75119040.sptg)
	e3:SetOperation(c75119040.spop)
	c:RegisterEffect(e3)
end
function c75119040.cfilter(c)
	return c:IsSetCard(0x10b) and c:IsType(TYPE_MONSTER)
end
function c75119040.atkcon(e)
	local g=Duel.GetMatchingGroup(c75119040.cfilter,e:GetHandler():GetControler(),LOCATION_GRAVE,0,nil)
	return g:GetClassCount(Card.GetCode)>=3 and g:IsExists(Card.IsCode,1,nil,94365540)
end
function c75119040.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x10b)
end
function c75119040.atkval(e,c)
	return c:GetLinkedGroup():FilterCount(c75119040.atkfilter,nil)*500
end
function c75119040.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end
function c75119040.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,75119041,0x10b,TYPES_TOKEN_MONSTER,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c75119040.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,75119041,0x10b,TYPES_TOKEN_MONSTER,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,75119041)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end

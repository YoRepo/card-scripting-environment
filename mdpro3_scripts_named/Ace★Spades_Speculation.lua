--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: A★黑桃之猜大小剑士  (ID: 10796448)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 7
-- ATK 2500 | DEF 2500
--
-- Effect Text:
-- 攻击力2500以上的怪兽＋守备力2500以下的里侧守备表示怪兽
-- 自己对「A★黑桃之猜大小剑士」1回合只能有1次特殊召唤。
-- ①：这张卡得到表示形式的以下效果。
-- ●攻击表示：这张卡的攻击力上升对方场上的怪兽的最高原本攻击力数值。
-- ●守备表示：这张卡不会被战斗·效果破坏。
-- ②：把1只攻击表示怪兽和1只里侧守备表示怪兽从自己场上解放才能发动。这张卡从墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--A★スペキュレーション
function c10796448.initial_effect(c)
	c:SetSPSummonOnce(10796448)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c10796448.ffilter1,c10796448.ffilter2,true)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c10796448.atkcon)
	e1:SetValue(c10796448.val)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c10796448.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCost(c10796448.spcost)
	e4:SetTarget(c10796448.sptg)
	e4:SetOperation(c10796448.spop)
	c:RegisterEffect(e4)
end
function c10796448.ffilter1(c)
	return c:IsAttackAbove(2500)
end
function c10796448.ffilter2(c)
	return c:IsDefenseBelow(2500) and c:IsFacedown() and c:IsDefensePos() and c:IsLocation(LOCATION_MZONE)
end
function c10796448.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c10796448.val(e,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,e:GetOwnerPlayer(),0,LOCATION_MZONE,nil)
	if g:GetCount()==0 then
		return 0
	else
		local tg,val=g:GetMaxGroup(Card.GetBaseAttack)
		return val
	end
end
function c10796448.indcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDefensePos()
end
function c10796448.costfilter(c)
	return c:IsReleasable() and ((c:IsFacedown() and c:IsDefensePos()) or (c:IsFaceup() and c:IsAttackPos()))
end
function c10796448.spcheck(g,tp)
	return Duel.GetMZoneCount(tp,g)>0 and aux.gfcheck(g,Card.IsPosition,POS_FACEUP_ATTACK,POS_FACEDOWN_DEFENSE)
end
function c10796448.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c10796448.costfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return g:CheckSubGroup(c10796448.spcheck,2,2,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=g:SelectSubGroup(tp,c10796448.spcheck,false,2,2,tp)
	Duel.Release(sg,REASON_COST)
end
function c10796448.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c10796448.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end

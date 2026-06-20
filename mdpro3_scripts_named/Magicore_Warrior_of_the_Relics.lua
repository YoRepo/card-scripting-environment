--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 遗迹的魔矿战士  (ID: 66078354)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- ATK 2300 | DEF 1000
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：自己场上有「勇者衍生物」存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：自己场上没有「勇者衍生物」存在的场合，这张卡不能攻击。
-- ③：有「勇者衍生物」的衍生物名记述的自己怪兽进行战斗的战斗阶段结束时才能发动。从卡组选有「勇者衍生物」的衍生物名记述的1张陷阱卡在自己的魔法与陷阱区域盖放。
--[[ __CARD_HEADER_END__ ]]

--遺跡の魔鉱戦士
function c66078354.initial_effect(c)
	aux.AddCodeList(c,3285552)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,66078354)
	e1:SetCondition(c66078354.spcon)
	e1:SetTarget(c66078354.sptg)
	e1:SetOperation(c66078354.spop)
	c:RegisterEffect(e1)
	--cannot atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c66078354.atkcon)
	c:RegisterEffect(e2)
	--set card
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SSET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,66078355)
	e3:SetCondition(c66078354.setcon)
	e3:SetTarget(c66078354.settg)
	e3:SetOperation(c66078354.setop)
	c:RegisterEffect(e3)
	if not c66078354.global_check then
		c66078354.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLED)
		ge1:SetOperation(c66078354.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c66078354.check(c)
	return c and aux.IsCodeListed(c,3285552)
end
function c66078354.checkop(e,tp,eg,ep,ev,re,r,rp)
	local a,d=Duel.GetBattleMonster(0)
	if c66078354.check(a) then Duel.RegisterFlagEffect(0,66078354,RESET_PHASE+PHASE_END,0,1) end
	if c66078354.check(d) then Duel.RegisterFlagEffect(1,66078354,RESET_PHASE+PHASE_END,0,1) end
end
function c66078354.cfilter(c)
	return c:IsCode(3285552) and c:IsFaceup()
end
function c66078354.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c66078354.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c66078354.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c66078354.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c66078354.atkcon(e)
	return not Duel.IsExistingMatchingCard(c66078354.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c66078354.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,66078354)>0
end
function c66078354.setfilter(c)
	return aux.IsCodeListed(c,3285552) and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function c66078354.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c66078354.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c66078354.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c66078354.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g)
	end
end

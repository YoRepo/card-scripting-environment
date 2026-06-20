--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 战华之雄-张德  (ID: 2801664)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Beast-Warrior
-- Level 7
-- ATK 2700 | DEF 900
-- Setcode: 311
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：自己场上有「战华」怪兽2只以上存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡的攻击力在自己回合内上升对方场上的怪兽数量×300。
-- ③：对方场上的怪兽数量比自己场上的怪兽多的场合才能发动。这个回合，这张卡在同1次的战斗阶段中最多2次可以向怪兽攻击。
--[[ __CARD_HEADER_END__ ]]

--戦華の雄－張徳
function c2801664.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2801664,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,2801664)
	e1:SetCondition(c2801664.spcon)
	e1:SetTarget(c2801664.sptg)
	e1:SetOperation(c2801664.spop)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c2801664.atkcon)
	e2:SetValue(c2801664.atkval)
	c:RegisterEffect(e2)
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(2801664,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,2801665)
	e3:SetCondition(c2801664.xatkcon)
	e3:SetTarget(c2801664.xatktg)
	e3:SetOperation(c2801664.xatkop)
	c:RegisterEffect(e3)
end
function c2801664.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x137)
end
function c2801664.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c2801664.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c2801664.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c2801664.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c2801664.atkcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
function c2801664.atkval(e,c)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)*300
end
function c2801664.xatkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)
		and Duel.IsAbleToEnterBP()
end
function c2801664.xatktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsHasEffect(EFFECT_EXTRA_ATTACK_MONSTER) end
end
function c2801664.xatkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		c:RegisterEffect(e1)
	end
end

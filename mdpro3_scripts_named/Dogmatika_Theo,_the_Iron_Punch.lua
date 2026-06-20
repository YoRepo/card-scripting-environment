--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 教导的铁锤 特奥  (ID: 96891787)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1800 | DEF 1500
-- Setcode: 325
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：从额外卡组特殊召唤的怪兽在场上存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡不会被和从额外卡组特殊召唤的怪兽的战斗破坏。
-- ③：以从额外卡组特殊召唤的场上1只表侧表示怪兽为对象才能发动。直到回合结束时，这张卡的攻击力上升600，作为对象的怪兽的攻击力下降600。
--[[ __CARD_HEADER_END__ ]]

--教導の鉄槌テオ
function c96891787.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96891787,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,96891787)
	e1:SetCondition(c96891787.spcon)
	e1:SetTarget(c96891787.sptg)
	e1:SetOperation(c96891787.spop)
	c:RegisterEffect(e1)
	--battle indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c96891787.indes)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(96891787,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,96891788)
	e3:SetTarget(c96891787.atktg)
	e3:SetOperation(c96891787.atkop)
	c:RegisterEffect(e3)
end
function c96891787.cfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c96891787.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c96891787.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c96891787.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c96891787.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c96891787.indes(e,c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c96891787.atkfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA) and c:IsFaceup()
end
function c96891787.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c96891787.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c96891787.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c96891787.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c96891787.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(600)
		c:RegisterEffect(e1)
		if tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e2:SetValue(-600)
			tc:RegisterEffect(e2)
		end
	end
end

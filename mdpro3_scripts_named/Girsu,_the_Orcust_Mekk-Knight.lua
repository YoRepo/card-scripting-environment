--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 宵星之骑士 吉尔苏  (ID: 69811710)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1800 | DEF 0
-- Setcode: 18546956
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤的场合才能发动。从卡组把1张「自奏圣乐」卡或「星遗物」卡送去墓地。和这张卡相同纵列有其他卡2张以上存在的场合，再在这个回合把这张卡当作调整使用。
-- ②：自己场上没有其他怪兽存在的场合才能发动。在双方场上把「星遗物衍生物」（机械族·暗·1星·攻/守0）各1只守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--宵星の騎士ギルス
function c69811710.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69811710,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,69811710)
	e1:SetTarget(c69811710.tgtg)
	e1:SetOperation(c69811710.tgop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(69811710,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,69811711)
	e3:SetCondition(c69811710.spcon)
	e3:SetTarget(c69811710.sptg)
	e3:SetOperation(c69811710.spop)
	c:RegisterEffect(e3)
end
c69811710.treat_itself_tuner=true
function c69811710.tgfilter(c)
	return c:IsSetCard(0x11b,0xfe) and c:IsAbleToGrave()
end
function c69811710.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c69811710.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c69811710.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c69811710.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE) then
		if c:GetColumnGroup():GetCount()>=2 and c:IsFaceup() and c:IsRelateToEffect(e) then
			Duel.BreakEffect()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_ADD_TYPE)
			e1:SetValue(TYPE_TUNER)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
	end
end
function c69811710.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())==0
end
function c69811710.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)
	if chk==0 then return ft1>0 and ft2>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,46647145,0xfe,TYPES_TOKEN_MONSTER,0,0,1,RACE_MACHINE,ATTRIBUTE_DARK,POS_FACEUP_DEFENSE,tp)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,46647145,0xfe,TYPES_TOKEN_MONSTER,0,0,1,RACE_MACHINE,ATTRIBUTE_DARK,POS_FACEUP_DEFENSE,1-tp)
		and not Duel.IsPlayerAffectedByEffect(tp,59822133) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
end
function c69811710.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)
	if ft1<=0 or ft2<=0 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,46647145,0xfe,TYPES_TOKEN_MONSTER,0,0,1,RACE_MACHINE,ATTRIBUTE_DARK,POS_FACEUP_DEFENSE,tp)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,46647145,0xfe,TYPES_TOKEN_MONSTER,0,0,1,RACE_MACHINE,ATTRIBUTE_DARK,POS_FACEUP_DEFENSE,1-tp) then
		local token=Duel.CreateToken(tp,69811711)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		local token=Duel.CreateToken(tp,69811711)
		Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
		Duel.SpecialSummonComplete()
	end
end

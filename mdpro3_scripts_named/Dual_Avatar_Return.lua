--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 双天的再来  (ID: 49752795)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 335
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己墓地1只「双天」怪兽为对象才能发动。那只怪兽特殊召唤。这个效果把原本等级是4星以下的「双天」怪兽特殊召唤的场合，可以再在自己场上把1只「双天魂衍生物」（战士族·光·2星·攻/守0）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--双天の再来
function c49752795.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,49752795+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c49752795.target)
	e1:SetOperation(c49752795.activate)
	c:RegisterEffect(e1)
end
function c49752795.filter(c,e,tp)
	return c:IsSetCard(0x14f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c49752795.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c49752795.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c49752795.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c49752795.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	local tc=g:GetFirst()
	if tc:GetOriginalLevel()<=4 then
		Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	end
end
function c49752795.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 and tc:GetOriginalLevel()<=4 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,87669905,0x14f,TYPES_TOKEN_MONSTER,0,0,2,RACE_WARRIOR,ATTRIBUTE_LIGHT) and Duel.SelectYesNo(tp,aux.Stringid(49752795,0)) then
			Duel.BreakEffect()
			local token=Duel.CreateToken(tp,49752796)
			Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end

--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 伊洛金异虫  (ID: 14936691)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Reptile
-- Level 6
-- ATK 2400 | DEF 1200
-- Setcode: 62
--
-- Effect Text:
-- 这张卡不能特殊召唤。选择场上表侧表示存在的1只名字带有「异虫」的爬虫类族怪兽变成里侧守备表示。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ワーム・イーロキン
function c14936691.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(14936691,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c14936691.postg)
	e2:SetOperation(c14936691.posop)
	c:RegisterEffect(e2)
end
function c14936691.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE) and c:IsCanTurnSet()
end
function c14936691.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c14936691.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c14936691.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c14936691.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c14936691.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE,0,POS_FACEDOWN_DEFENSE,0)
	end
end

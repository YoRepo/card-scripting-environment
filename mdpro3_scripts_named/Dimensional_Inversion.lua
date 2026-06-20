--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 反转次元  (ID: 98666339)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 原本的持有者是自己的怪兽被对方的效果从游戏中除外时才能发动。那1只怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--リバースディメンション
function c98666339.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c98666339.target)
	e1:SetOperation(c98666339.operation)
	c:RegisterEffect(e1)
end
function c98666339.filter(c,e,tp)
	return c:IsControler(tp) and c:IsFaceup() and c:GetReasonPlayer()==1-tp
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c98666339.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and eg:IsContains(chkc) and c98666339.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and eg:IsExists(c98666339.filter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=eg:FilterSelect(tp,c98666339.filter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c98666339.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

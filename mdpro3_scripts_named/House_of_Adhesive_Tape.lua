--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 粘胶带之家  (ID: 15083728)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方把守备力500以下的怪兽召唤·反转召唤时才能发动。那1只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--粘着テープの家
function c15083728.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c15083728.target)
	e1:SetOperation(c15083728.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c15083728.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=eg:GetFirst()
	if chkc then return chkc==tc end
	if chk==0 then return ep~=tp and tc:IsFaceup() and tc:GetDefense()<=500 and tc:IsOnField() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c15083728.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:GetDefense()<=500 then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
